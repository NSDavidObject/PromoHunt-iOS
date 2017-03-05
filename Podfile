platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

def shared_pods
	pod 'SnapKit'
	pod 'Fabric'
	pod 'Crashlytics'
	pod 'Alamofire'
    pod 'Shimmer'
	pod 'CommonUtilities', :path => "../../CommonUtilities/"
	pod 'Cletrol', :path => "../../DataViewController/"
	#pod 'Cletrol', :git => "https://github.com/NSDavidObject/Cletrol.git"
	#pod 'CommonUtilities', :git => "https://github.com/davoda/CommonUtilities.git"
end

target "PromoHunt" do
	shared_pods
end

target "PromoHuntTests" do
	shared_pods
end
