definition
newBuilder
	^ FmxNGGenerator builderWithDefinitions
		doNotGenerateCurrent;
		packageName: self class packageName;
		generator: self;
		yourself