# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

class MyUglifyCompressor < Schmooze::Base
  dependencies uglify: 'uglify-js'

  method :minify, %q{function(code) {
  try {
    return uglify.minify(code, { fromString: true });
  } catch (err) {
    if (err.codeFrame != null) {
      err.message += "\n";
      err.message += err.codeFrame;
    }
    throw err;
  }
}}

  VERSION = '1'

  def self.instance(env)
    @instance ||= new(env.root)
  end

  def self.call(input)
    instance(input[:environment]).call(input)
  end

  def initialize(root)
    super(root)
  end

  def call(input)
    minify(input[:data])['code']
  end
end

Rails.application.config.assets.configure do |env|
  env.register_compressor 'application/javascript', :my_uglify, MyUglifyCompressor
end
