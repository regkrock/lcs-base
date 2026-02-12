Class {
	#name : 'LcsAddressTest',
	#superclass : 'LcsDemoSystemRunningTestCase',
	#category : 'Lcs-GeographyTests-Tests',
	#package : 'Lcs-GeographyTests',
	#tag : 'Tests'
}

{ #category : 'tests' }
LcsAddressTest >> testCreation [
	| address addresses |
	
	self assert: LcsAddress slotModel hasSlotDefinitions.
	addresses := self currentSystem geographyModule addresses.
	self assert: addresses hasNoPendingAdds.
	address := LcsAddress new.
	self assert: addresses pendingAddsSize equals: 1.
	self assert: address parent equals: addresses.
	self assert: address addressType isUnknown
]
