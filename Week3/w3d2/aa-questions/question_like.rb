require_relative 'questions_database'
require_relative 'question_follow'

class QuestionLike
  TABLE_NAME = "question_likes"

  attr_accessor :id, :user_id, :question_id

  def self.find_by_id(id)
    likes_rows = QuestionsDatabase.instance.execute(<<-SQL, id: id)
                  SELECT
                    *
                  FROM
                    #{TABLE_NAME}
                  WHERE
                    id = :id
                  LIMIT
                    1
                SQL

    likes_hash = likes_rows.first
    QuestionLike.new(likes_hash)
  end

  def self.likers_for_question_id(question_id)
    users_rows = QuestionsDatabase.instance
                                  .execute(<<-SQL, q_id: question_id)
                   SELECT
                     users.*
                   FROM
                     question_likes
                   JOIN
                     users ON users.id = question_likes.user_id
                   WHERE
                     question_likes.question_id = :q_id

                 SQL
    users_rows.map { |u_hash| User.new(u_hash) }
  end

  def self.num_likes_for_question_id(question_id)
    likes=QuestionsDatabase.instance
                           .execute(<<-SQL, question_id: question_id)
                  SELECT
                    count(*) as ct
                  FROM
                    #{TABLE_NAME}
                  WHERE
                    question_likes.question_id = :question_id
               SQL
    likes.first["ct"] #need to change
  end

  def self.liked_questions_for_user_id(user_id)
    questions_rows = QuestionsDatabase.instance
                                      .execute(<<-SQL, u_id: user_id)
             SELECT
               questions.*
             FROM
               #{TABLE_NAME}
             JOIN
               questions ON questions.id = #{TABLE_NAME}.question_id
             WHERE
               #{TABLE_NAME}.user_id = :u_id
           SQL
   questions_rows.map { |q_hash| Question.new(q_hash) }
  end

  def self.most_liked_questions(n)
    questions_rows = QuestionsDatabase.instance
                                      .execute(<<-SQL, q_limit: n)
      SELECT
        questions.*
      FROM
        #{TABLE_NAME}
      JOIN
        questions ON questions.id = #{TABLE_NAME}.question_id
      GROUP BY
        #{TABLE_NAME}.question_id
      ORDER BY
        count(#{TABLE_NAME}.*)
      LIMIT :q_limit
    SQL
  end

  def initialize(options = {})
    @id = options["id"]
    @user_id = options["user_id"]
    @question_id = options["question_id"]
  end
end
