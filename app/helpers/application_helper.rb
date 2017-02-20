module ApplicationHelper
  def avg_by_child_hash_key(arr, key)
    sum = arr.reduce(0) { |sum, hash| sum + hash[key] }
    avg = sum / arr.size if arr.size > 0
    avg ||= 0
  end
end
