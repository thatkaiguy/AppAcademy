require_relative 'questions_database'
require_relative 'question'
require_relative 'reply'
require_relative 'question_follow'
require_relative 'question_like'
require 'byebug'

class User

  attr_accessor :fname, :lname
  attr_reader :id

  TABLE_NAME = "users"

  def self.find_by_id(id)
    user_rows = QuestionsDatabase.instance
                                 .execute(<<-SQL, :id => id)
                  SELECT
                    *
                  FROM
                    #{TABLE_NAME}
                  WHERE
                    id = :id
                SQL

    user_hash = user_rows.first
    User.new(user_hash)
  end

  def self.find_by_name(fname, lname)
    user_rows = QuestionsDatabase.instance
                                 .execute(<<-SQL, fname: fname, lname: lname)
                  SELECT
                    *
                  FROM
                    #{TABLE_NAME}
                  WHERE
                    fname = :fname AND
                    lname = :lname
                SQL
    user_rows.map { |u_hash| User.new(u_hash) }
  end

  def initialize(options = {})
    @id = options["id"]
    @fname = options["fname"]
    @lname = options["lname"]
  end

  def authored_questions
    Question.find_by_author_id(id)
  end

  def authored_replies
    Reply.find_by_user_id(id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(id)
  end

  def average_karma
    avg_row = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        count(question_likes.user_id) /
        CAST(count(DISTINCT(questions.id)) AS FLOAT)
      FROM
        questions
      LEFT OUTER JOIN
        question_likes ON questions.id = question_likes.question_id
      WHERE
        questions.user_id = ?
    SQL

    avg_row.first.values[0]
  end

  def save
    begin
      if id.nil? &&
        !self.fname.nil? &&
        !self.lname.nil?
        QuestionsDatabase
          .instance
          .execute(<<-SQL, fname: self.fname, lname: self.lname)
          INSERT INTO
            #{TABLE_NAME} (fname, lname)
          VALUES
            (:fname, :lname)
          SQL
        self.id = QuestionsDatabase.instance.last_insert_row_id
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
             self.fname.nil? ||
             self.lname.nil?
        QuestionsDatabase
          .instance
          .execute(<<-SQL, id: id, fname: self.fname, lname: self.lname)
          UPDATE
            #{TABLE_NAME}
          SET
            name = :fname, lname = :lname
          WHERE
            id = :id
        SQL
      end
      true
    rescue
      false
    end
  end

  private
  attr_writer :id
end
