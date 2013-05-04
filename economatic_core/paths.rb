ROOT_PATH = File.dirname(__FILE__)

%w(contexts entities extras roles composers).each do |folder|
  $LOAD_PATH << File.join(ROOT_PATH, 'app', folder)
end
$LOAD_PATH << File.join(ROOT_PATH, 'framework')