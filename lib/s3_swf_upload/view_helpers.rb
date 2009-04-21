module S3SwfUpload
  module ViewHelpers
    def s3_swf_upload_tag(options = {})
      height     = options[:height] || 35
      width      = options[:width]  || 300
      success    = options[:success]  || ''
      failed     = options[:failed]  || ''
      selected   = options[:selected]  || ''
      canceled     = options[:canceled] || ''
      prefix     = options[:prefix] || 's3_swf'
      
      @@count ||= 1
      
      out = ""
      out << %(
        <script type="text/javascript" src="/javascripts/s3_upload.js"></script>

        <script type="text/javascript">
            var s3_swf#{@@count} = s3_swf_init('s3_upload#{@@count}', {
              width:  #{width},
              height: #{height},
              onSuccess: function(){
                #{success}
              },
              onFailed: function(status){
                #{failed}
              },
              onFileSelected: function(filename, size){
                #{selected}
              },
              onCancel: function(){
                #{canceled}
              }
            });
        </script>

        <div id="s3_upload#{@@count}">
          Please <a href="http://www.adobe.com/go/getflashplayer">Update</a> your Flash Player to Flash v9.0.1 or higher...
        </div>

        <a href="#" onclick="s3_swf#{@@count}.init(); s3_swf#{@@count}.upload('#{prefix}/')">Upload</a>
      )
      
      @@count += 1
      @@count = 1 if @@count > 100
      out
    end
  end
end

ActionView::Base.send(:include, S3SwfUpload::ViewHelpers)
