# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
target 'Instagram' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    
    # Pods for Instagram
    
    
    pod 'Parse'
    
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.2'
            end
        end
    end
    pod 'ParseUI'
end
#target 'Instagram' do
# Comment the next line if you're not using Swift and don't want to use dynamic frameworks
#use_frameworks!

# Pods for Instagram
#pod 'Parse'

#target 'InstagramTests' do
#inherit! :search_paths
# Pods for testing
#end

#target 'InstagramUITests' do
#inherit! :search_paths
# Pods for testing
#end

#end

