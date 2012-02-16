We cannot use VCR to test the blog feeds because they do not support Curl::Multi which is what feedzirra uses.  We test using file://path/to/these/xml/files instead.

* [VCR readme](https://github.com/myronmarston/vcr) "Curb (when using WebMock -- only supports Curl::Easy at the moment)"
* [Feedzirra Discussion](https://groups.google.com/forum/#!topic/feedzirra/J58t3uJTSWw) see 7/7/11 comment by bramswenson "since feedzirra is using Curl::Multi, it isn't very testable (with vcr)"