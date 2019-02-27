if Rails.env.production?
  url = 'portal.managedapps.co'
  class Swagger::Docs::Config
    def self.transform_path(path, api_version)
      # Make a distinction between the APIs and API documentation paths.
      "assets/apidocs/#{path}"
    end
  end
  file_path = 'public/assets/apidocs'
else
  class Swagger::Docs::Config
    def self.transform_path(path, api_version)
      # Make a distinction between the APIs and API documentation paths.
      "/apidocs/#{path}"
    end
  end
  url = 'http://localhost:3333'
  file_path = 'public/apidocs'
end
Swagger::Docs::Config.register_apis({
                                        '1.0' => {
                                            api_file_path: file_path,
                                            base_path: url,
                                            clean_directory: true,
                                            :attributes => {
                                                :info => {
                                                    title: 'managedapps',
                                                    description: 'Api created for ManagedApps',
                                                    contact: 'gil@bytefly.com'
                                                }
                                            }}})