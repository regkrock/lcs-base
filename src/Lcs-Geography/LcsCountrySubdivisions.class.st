Class {
	#name : #LcsCountrySubdivisions,
	#superclass : #LcsDomainCollection,
	#category : #'Lcs-Geography-Domain'
}

{ #category : #'slot definitions' }
LcsCountrySubdivisions class >> defaultInstanceSlotDefinition [
	<virtualSlotDefinition>
	^ LcsDefaultInstanceSlot new
		slotTypes: (OrderedCollection with: LcsBaseCountrySubdivision);
		yourself
]

{ #category : #queries }
LcsCountrySubdivisions >> defaultInstance [
	^ self 
		find: [ :each | each formalName = 'Unknown' ]
		ifNone: [ 
			(self parent subdivisionClass newInContextOf: self parent)
				formalName: 'Unknown';
				yourself ]
]
