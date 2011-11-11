SocialVoltHash aims to take multidimensional data and to turn that into a hash.

The best use case is to build an encoder that takes n dimensions and has the max and min from -2..2

-2..2 is special cause it covers >95% of the distribution of anything if you normalize data.  

So for instance z = (x - mu) / stdev will be between -2..2 over 95% of the time.

when we have this we can create hashes that are monotonically increasing by the multiple data points

