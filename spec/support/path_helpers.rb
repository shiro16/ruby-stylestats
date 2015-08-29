def fixtures_path_for(file=nil)
  'spec/fixtures/' + file.to_s
end

def spec_css_path
  fixtures_path_for('spec.css')
end
