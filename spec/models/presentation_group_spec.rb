describe PresentationGroup do
  it { should_not have_valid(:presentation_id).when(nil) }
  it { should_not have_valid(:presentation_id).when('IMA STRING') }
  it { should_not have_valid(:presenter_id).when(nil) }
  it { should_not have_valid(:presenter_id).when('IMA STRING') }  
end