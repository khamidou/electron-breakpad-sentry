require 'os'
require 'sinatra'
require 'sentry_breakpad'
require 'raven'


get '/' do
  "heroku-breakpad-sentry is a simple breakpad server which forwards data to sentry. It's very easy to deploy to heroku."
end


post '/crashreport' do
  unless params[:upload_file_minidump] and params[:upload_file_minidump][:filename]
    halt 400, "Need to pass minidump upload"
  end

  # Electron sends us crash reports in the minidump format.
  # We need to read them and run minidump_stackwalk to be
  # able to see them in an intelligible format.
  file = params[:upload_file_minidump][:tempfile]
  tmpfile = Tempfile.new('minidump')

  begin
    tmpfile.write(file.read)

    res = ''
    if OS.mac?
      res = `./minidump_stackwalk_mac #{tmpfile.path}`
    elsif OS.linux? and OS.bits == 64
      res = `./minidump_stackwalk_linux64 #{tmpfile.path}`
    end

    SentryBreakpad.send_from_string(res)
  ensure
    tmpfile.close
    tmpfile.unlink
  end

  return 'ok'
end
