Class {
	#name : 'LcsCountrySubdivisions',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-Geography-Domain',
	#package : 'Lcs-Geography',
	#tag : 'Domain'
}

{ #category : 'slot definitions' }
LcsCountrySubdivisions class >> defaultInstanceSlotDefinition [
	<virtualSlotDefinition>
	^ LcsDefaultInstanceSlot new
		slotTypes: (OrderedCollection with: LcsBaseCountrySubdivision);
		yourself
]

{ #category : 'queries' }
LcsCountrySubdivisions >> defaultInstance [
	^ self 
		find: [ :each | each formalName = 'Unknown' ]
		ifNone: [ 
			(self parent subdivisionClass newInContextOf: self parent)
				formalName: 'Unknown';
				yourself ]
]

{ #category : 'querrying' }
LcsCountrySubdivisions >> findItemMatchingCode: anObject [
	| result |
	anObject isString ifFalse: [ ^ anObject ].
	result := self collection
			detect: [ :each | each isoCode = anObject ]
			ifNone: [ nil ].
	result ifNotNil: [ ^ result ].
	^ self pendingAdds
			detect: [ :each | each isoCode = anObject ]
			ifNone: [ anObject ].
]
