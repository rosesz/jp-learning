# == Schema Information
#
# Table name: learnings
#
#  id         :integer          not null, primary key
#  start_date :datetime
#  end_date   :datetime
#  user_id    :integer
#  course_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Learning < ActiveRecord::Base
  belongs_to :course
  belongs_to :user

  after_create :set_start_date, :create_progresses

  private

  def set_start_date
    start_date = created_at
  end

  def create_progresses
    course.words.each do |word|
      LearnedWord.create(user: user, word: word, last_learned: Time.now)
    end
  end
end