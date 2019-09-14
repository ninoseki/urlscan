# frozen_string_literal: true

module UrlScan
  class CLI < Commands::Community
    desc "pro", "PRO api commands"
    subcommand "pro", Commands::Pro
  end
end
