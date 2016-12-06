require './spec/spec_helper'

describe Corporation do
  let(:player) { Player.new 1, 'Test' }
  let(:market) { SharePrice.initial_market }
  let(:share_price) { market[6] }
  let(:company) { Company.new player, *(['BME'].concat Company::COMPANIES['BME']) }
  subject { Corporation.new 'Bear', company, share_price, market }

  describe '#buy_company' do
    let(:company_to_buy) { Company.new player, *(['BSE'].concat Company::COMPANIES['BSE']) }

    it 'cash gets removed' do
      expect { subject.buy_company company_to_buy, 10 }.to change { subject.cash }.by(-10)
    end

    it 'adds company to companies' do
      expect(subject.companies.find { |c| c == company_to_buy }).to be_nil
      subject.buy_company company_to_buy, 10
      expect(subject.companies.find { |c| c == company_to_buy }).to eq(company_to_buy)
    end

    it 'removes company from seller' do
      player.companies << company_to_buy
      expect { subject.buy_company company_to_buy, 10}.to change { player.companies.size }.by(-1)
    end

    it 'can_buy_shares should return false if bank shares is empty' do
      expect(subject.can_buy_share?).to eq(true)
    end

  end

  describe '#is_bankrupt' do
    it 'company is not bankrupt' do
      expect(subject.is_bankrupt?).to eq(false)
    end
  end

  describe "#issue_share" do
    it "can issue a share" do
      expect(subject.can_issue_share?).to be(true)
    end

    it "adds money to cash" do
      expect { subject.issue_share }.to change { subject.cash }.by(9)
    end

    it "reduces the number of available shares" do
      expect { subject.issue_share }.to change { subject.shares.size }.by(-1)
    end
  end

  describe '#close_company' do
    it 'removes the company from the corporation.' do
      expect { subject.close_company company }.to change { subject.companies.size }.by(-1)
    end
  end

  describe '#collect income' do
    it 'increases cash' do
      expect(subject.companies.size).to eq(1)
      expect { subject.collect_income :red }.to change { subject.cash }.by(1)
    end
  end

  # Don't know how to create and pass in an array
  #describe '#pay_dividend' do

  describe '#book_value' do
    it 'is worth some money' do
      expect(subject.book_value).to eq(20)
    end
  end

  describe '#market_cap' do
    it 'returns a value' do
      expect(subject.market_cap).to eq(20)
    end
  end

end