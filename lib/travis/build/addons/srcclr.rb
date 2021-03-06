require 'shellwords'

require 'travis/build/addons/base'

module Travis
  module Build
    class Addons
      class Srcclr < Base
        SUPER_USER_SAFE = true

        def before_finish
          srcclr_config = @config.to_s.strip.shellescape

          sh.if('$TRAVIS_TEST_RESULT = 0') do
            sh.fold 'after_success' do
              if srcclr_config.casecmp('true') == 0
                sh.cmd "curl -sSL https://download.sourceclear.com/ci.sh | bash", echo: true, timing: true
              elsif srcclr_config.casecmp('false') == 0
                sh.echo 'srcclr: false specified. Not including srcclr addon.'
              else
                sh.echo 'Unknown option \'' + srcclr_config + '\' specified. Not including srcclr addon.'
              end
            end
          end
        end
      end
    end
  end
end
