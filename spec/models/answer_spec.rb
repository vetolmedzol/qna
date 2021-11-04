require 'rails_helper'

RSpec.describe(Answer, type: :model) do
  it { is_expected.to(validate_presence_of(:title)) }
  it { is_expected.to(belong_to(:question)) }
end
