require './spec/spec_helper'

describe Views::Page do
  let(:app) { double 'RollingStock', current_user: nil, csrf_tag: nil, request: nil }

  it 'should render' do
    view = Views::Page.new app: app
    expect(view.to_html).not_to be_nil
  end
end
