CACHE = Rails.cache

# For extending models and assocations to provide an time based version number
# for cache expiration by changing part of the key we lookup the cache by.
module Versionable
  TTL = 0 # permanent
  
  # Returns the current version of the assocation. Likely to be nil.
  def version
    CACHE.read(version_cache_key)
  end

  # Sets the version of this assocation to the current time in integer form.
  def new_version
    # the expiry needs to be longer than any page that might use this as a
    # cache key.
    time = Time.now.to_i
    CACHE.write(version_cache_key, time, :expires_in => TTL)
    time
  end

  # Returns the association version key.
  def version_cache_key
    parts =
      if object.class == Class
        [object]
      else
        [object.class, object.id]
      end
      
    parts << version_name
    parts * ':'
  end
  
  # Returns the object that version applies to.
  def object
    if inside_association?
      proxy_owner
    else
      self
    end
  end
  
  # Returns the name portion of the version cache key
  def version_name
    if inside_association?
      "#{proxy_reflection.name}_version"
    else
      "version"
    end
  end
  
  private
    
  # Returns true if this is called with the context available to an 
  # assocation.
  def inside_association?
    # TODO: see if we can memoize
    self.respond_to?(:proxy_owner)
  end
  
end