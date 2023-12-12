class RubyVM::InstructionSequence
  def self.load_iseq(filepath)
    compile_file_prism(filepath)
  end
end
