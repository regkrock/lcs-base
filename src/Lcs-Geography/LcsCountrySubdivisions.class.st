Class {
	#name : 'LcsCountrySubdivisions',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-Geography-Core',
	#package : 'Lcs-Geography',
	#tag : 'Core'
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
			self parent subdivisions add: (
				self parent subdivisionClass new
					formalName: 'Unknown';
					yourself) ]
]

{ #category : 'querrying' }
LcsCountrySubdivisions >> findItemMatchingCode: aCode [
	self findItemMatchingCode: aCode ifNone: [ nil ]
]

{ #category : 'querrying' }
LcsCountrySubdivisions >> findItemMatchingCode: aCode ifNone: aBlock [
	^ self
		find: [ :each | each isoCode = aCode ]
		ifNone: aBlock
]
