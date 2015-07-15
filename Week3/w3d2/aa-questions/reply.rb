require_relative 'questions_database'
require_relative 'user'
require_relative 'question'
require 'byebug'

class Reply
  TABLE_NAME = "replies"

  attr_accessor :id, :parent_id, :question_id, :user_id, :body

  def self.find_by_id(id)
    return Reply.new if id.nil?

    reply_rows = QuestionsDatabase.instance.execute(<<-SQL, :id => id)
                  SELECT
                    *
                  FROM
                    #{TABLE_NAME}
                  WHERE
                    id = :id
                SQL

    reply_hash = reply_rows.first
    Reply.new(reply_hash)
  end

  def self.find_by_user_id(user_id)
    return [] if user_id.nil?

    reply_rows = QuestionsDatabase.instance
                                  .execute(<<-SQL, user_id: user_id)
                      SELECT
                        *
                      FROM
                        #{TABLE_NAME}
                      WHERE
                        user_id = :user_id
                    SQL
    reply_rows.map { |r_hash| Reply.new(r_hash) }
  end

  def self.find_by_question_id(question_id)
    return [] if question_id.nil?

    reply_rows = QuestionsDatabase.instance
                                  .execute(<<-SQL, question_id: question_id)
                      SELECT
                        *
                      FROM
                        #{TABLE_NAME}
                      WHERE
                        question_id = :question_id
                    SQL
    reply_rows.map { |r_hash| Reply.new(r_hash) }
  end

  def self.find_by_parent_id(parent_id)
    return [] if parent_id.nil?

    reply_rows = QuestionsDatabase.instance
                                  .execute(<<-SQL, parent_id: parent_id)
                      SELECT
                        *
                      FROM
                        #{TABLE_NAME}
                      WHERE
                        parent_id = :parent_id
                    SQL
    reply_rows.map { |r_hash| Reply.new(r_hash) } .first
  end

  def initialize(options = {})
    @id = options["id"]
    @parent_id = options["parent_id"]
    @question_id = options["question_id"]
    @user_id = options["user_id"]
    @body = options["body"]
  end

  def author
    User.find_by_id(self.user_id)
  end

  def question
    Question.find_by_id(self.question_id)
  end

  def parent_reply
    Reply.find_by_id(self.parent_id)
  end

  def child_replies
    Reply.find_by_parent_id(self.id)
  end

  def save
    begin
      if id.nil? &&
         !parent_id.nil? &&
         !question_id.nil? &&
         !user_id.nil?

         params_hash = {p_id: parent_id, q_id: question_id,
                        u_id: user_id, body: body}
         QuestionsDatabase.instance.
         execute(<<-SQL, params_hash)
          INSERT INTO
            #{TABLE_NAME} (parent_id, question_id, user_id, body)
          VALUES
            (:p_id, :q_id, :user_id, :body)
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
             parent_id.nil? &&
             question_id.nil? &&
             user_id.nil?

        params_hash = {id: id, p_id: parent_id, q_id: question_id,
                       u_id: user_id, body: body}
        QuestionsDatabase.instance.
        execute(<<-SQL, params_hash)
          UPDATE
            #{TABLE_NAME}
          SET
            parent_id = :p_id, question_id = :q_id, user_id = :u_id, body =:body
          WHERE
            id = :id
        SQL
      end
      true
    rescue
      false
    end
  end
end
