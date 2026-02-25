Class {
	#name : 'LcsAddressesExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-GeographyTests-Examples',
	#package : 'Lcs-GeographyTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsAddressesExamples >> newAddressesCollection [
	<gtExample>
	| domainCollection |
	self ensureCurrentSystemIsDemoSystem.
	domainCollection :=  LcsAddresses new.
	self assert: domainCollection hasNoElements.
	self assert: domainCollection hasNoPendingAdds.
	self assert: domainCollection hasNoPendingDeletes.
	self assert: domainCollection unknownInstance class == LcsUnknownAddress.
	^ domainCollection
]

{ #category : 'examples' }
LcsAddressesExamples >> newAddressesWithOneAddress [
	<gtExample>
	| addresses canadianAddress |
	addresses := self newAddressesCollection.
	canadianAddress := LcsAddressExamples new canadaAddress.
	addresses add: canadianAddress.
	self assert: (addresses pendingAdds includes: canadianAddress). 
	^ addresses

]
