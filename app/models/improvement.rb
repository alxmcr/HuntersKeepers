# frozen_string_literal: true

# Improvements are associated with Playbooks
# These are the options the Hunter can choose
# from when upgrading their character.
class Improvement < ApplicationRecord
  IMPROVEMENT_TYPES = %w[Improvement Improvements::RatingBoost Improvements::PlaybookMove].freeze

  belongs_to :playbook

  enum rating: { charm: 0, cool: 1, sharp: 2, tough: 3, weird: 4 }

  validates :description, presence: true
  validates :type, inclusion: { in: IMPROVEMENT_TYPES }, allow_blank: true

  def apply(hunters_improvement)
    return false if add_errors(hunters_improvement)
    true
  end

  def hunter_playbook_matches?(hunter)
    hunter.playbook == playbook
  end

  def add_errors(hunters_improvement)
    hunter = hunters_improvement.hunter
    hunters_improvement.errors.add(:hunter, "does not match improvement playbook: #{playbook.name}") unless hunter_playbook_matches?(hunter)
  end
end
