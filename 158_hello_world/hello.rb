class Hello; def self.world!; [self, __callee__].join(' '); end; end

puts Hello.world!
