# Locomotion
[![Code Climate](https://codeclimate.com/github/JonRowe/locomotion.png)](https://codeclimate.com/github/JonRowe/locomotion)

Locomotion is a location aware library for iOS applications written in
RubyMotion. It exists to tirelessly update your application with a users
location.

**Note** unlike BubbleWrap, Locomotion does not consider loosing GPS signal
to be an error, and will keep retrying forever until you tell it to stop.

## Installation

Add this line to your application's Gemfile:

    gem 'locomotion'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install locomotion

## Usage

To start watching a users location changes, use `watch`, you can optionally
specify a purpose for the permission dialog if you like (`purpose: 'my cool app'`)

```Ruby
Locomotion.watch do |location_details|
  #perform your
end
```

Location details exposes `latitude`, `longitude`, `speed`, `heading`, `time`
and `accuracy`. You can also compare them to any other location object responding
to `latitude` and `longitude` to get a distance in km.

To pause updates for a certain period of time, use:

```Ruby
Locomotion.defer 10 #seconds
```

To stop tracking location...

```Ruby
Locomotion.stop
```

## Configuration

### Accuracy:
Choose from :best_for_navigation, :best, :nearest_ten, :nearest_hundred,
:nearest_km, :nearest_3km

```Ruby
Locomotion.accuracy = :best
```

### Distance:
Set a number in km or set to `nil` for none.

```Ruby
Locomotion.distance_filter = 3
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
