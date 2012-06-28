class Numeric
  def percent_of(n)
    score = self.to_f / n.to_f * 100.0
    if score.nan?
      return 0.0
    else
      return score 
    end
  end
end
