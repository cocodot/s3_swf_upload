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
      
      out = ""
      out << %(
        <script type="text/javascript" src="/javascripts/s3_upload.js"></script>

        <script type="text/javascript">
            s3_swf = s3_swf_init('s3_upload', {
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

        <div id="s3_upload">
          Please <a href="http://www.adobe.com/go/getflashplayer">Update</a> your Flash Player to Flash v9.0.1 or higher...
        </div>

        <a href="#" onclick="s3_swf.upload('#{prefix}/')">Upload</a>
      )
    end
  end
end

ActionView::Base.send(:include, S3SwfUpload::ViewHelpers)
