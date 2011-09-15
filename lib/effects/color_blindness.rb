module Effects
  class ColorBlindness
    def output text, opts = {}
      puts (opts.merge({:color => nil}))
      [text,opts.merge({:color => nil})]
    end
  end
end
