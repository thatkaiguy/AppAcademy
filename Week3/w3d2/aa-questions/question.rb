require_relative 'questions_database'
require_relative 'user'
require_relative 'reply'
require_relative 'question_follow'
require_relative 'question_like'

class Question
  TABLE_NAME = "questions"

  attr_accessor :id, :title, :body, :author, :user_id

  def self.find_by_id(id)
    question_rows = QuestionsDatabase.instance.execute(<<-SQL, id: id)
      SELECT
        *
      FROM
        #{TABLE_NAME}
      WHERE
        id = :id
    SQL

    question_hash = question_rows.first
    Question.new(question_hash)
  end

  def self.find_by_author_id(author_id)
    question_rows = QuestionsDatabase.
      instance.
      execute(<<-SQL, author_id: author_id)
                      SELECT
                        *
                      FROM
                        #{TABLE_NAME}
                      WHERE
                        user_id = :author_id
                    SQL

    question_rows.map { |q_hash| Question.new(q_hash) }
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def initialize(options = {})
    @id = options["id"]
    @title = options["title"]
    @body = options["body"]
    @user_id = options["user_id"]
  end

  def author
    User.find_by_id(self.user_id)
  end

  def replies
    Reply.find_by_question_id(self.id)
  end

  def likers
    QuestionLike.likers_for_question_id(self.id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(self.id)
  end

  def save
    begin
      if id.nil? &&
         !self.title.nil? &&
         !self.user_id.nil?
         QuestionsDatabase.instance.
         execute(<<-SQL, title: title, body: body, user_id: user_id)
           INSERT INTO
            #{TABLE_NAME} (title, body, user_id)
           VALUES
            (:title, :body, :user_id)
         SQL
      else
        self.update
      end
      true
    rescue
      false
    end
  end

  def update
    begin
      unless id.nil? ||
             title.nil? ||
             user_id.nil?
        QuestionsDatabase.instance.
        execute(<<-SQL, id: id, title: title, body: body, user_id: user_id)
          UPDATE
            #{TABLE_NAME}
          SET
            title = :title, body = :body, user_id = :user_id
          WHERE
            id = :id
        SQL
        self.id = QuestionsDatabase.instance.last_insert_row_id
      end
      true
    rescue
      false
    end
  end
end
