require 'kconv'
result = ''

@datum.results.each do |data|
  result << data
  result << "\r"
end
result.kconv(Kconv::SJIS, Kconv::UTF8)