require_relative 'questions_database'
require_relative 'user'
require_relative 'question'

class QuestionFollow
  TABLE_NAME = 'question_follows'

  attr_accessor :user_id, :question_id

  def self.find_by_id(id)
    follows_rows = QuestionsDatabase.instance.execute(<<-SQL, id: id)
                    SELECT
                      *
                    FROM
                      #{TABLE_NAME}
                    WHERE
                      id = :id
                  SQL

    follows_hash = follows_rows.first
    QuestionFollow.new(follows_hash)
  end

  def self.followers_for_question_id(question_id)
    users_rows = QuestionsDatabase.instance
                                  .execute(<<-SQL, question_id: question_id)
                    SELECT
                      users.*
                    FROM
                      #{TABLE_NAME}
                    JOIN
                      users ON users.id = #{TABLE_NAME}.user_id
                    WHERE
                      #{TABLE_NAME}.question_id = :question_id
                  SQL

    users_rows.map { |u_hash| User.new(u_hash) }
  end

  def self.followed_questions_for_user_id(user_id)
    question_rows = QuestionsDatabase.instance
                                     .execute(<<-SQL, user_id: user_id)
                    SELECT
                      questions.*
                    FROM
                      #{TABLE_NAME}
                    JOIN
                      questions ON questions.id = #{TABLE_NAME}.question_id
                    WHERE
                      #{TABLE_NAME}.user_id = :user_id
                  SQL

    question_rows.map { |q_hash| Question.new(q_hash) }
  end

  def self.most_followed_questions(n)
    question_rows = QuestionsDatabase
                      .instance
                      .execute(<<-SQL, user_id: user_id, q_limit: n )
                    SELECT
                      questions.*
                    FROM
                      #{TABLE_NAME}
                    JOIN
                      questions ON questions.id = #{TABLE_NAME}.question_id
                    GROUP BY
                      #{TABLE_NAME}.question_id
                    ORDER BY
                      count(#{TABLE_NAME}.*) DESC
                    LIMIT :q_limit
                  SQL

    question_rows.map { |q_hash| Question.new(q_hash) }
  end

  def initialize(options = {})
    @user_id = options["user_id"]
    @question_id = options["question_id"]
  end

  def followers
    QuestionFollow.followers_for_question_id(self.question_id)
  end
end
