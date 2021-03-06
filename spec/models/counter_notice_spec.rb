require 'spec_helper'

describe CounterNotice do
  it { should validate_presence_of :attach_list_of_works }
  it { should validate_presence_of :list_removed_in_error }
  it { should validate_presence_of :perjury_risk_acknowledged }
  it { should validate_presence_of :consent_to_be_served }
  it { should validate_presence_of :jurisdiction }

  context "jurisdictions" do
    it "knows when it's in the US" do
      counter_notice = build(:counter_notice, :in_us)

      expect(counter_notice.in_us?).to be_true
    end

    it "knows when it's outside the US" do
      counter_notice = build(:counter_notice, :outside_us)

      expect(counter_notice.in_us?).to be_false
    end
  end

end
