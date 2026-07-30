Class {
	#name : 'LxxSubsetSkills',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-PrototypeSystem-Core',
	#package : 'Lcs-PrototypeSystem',
	#tag : 'Core'
}

{ #category : 'collection' }
LxxSubsetSkills >> actualCollection [
	| items |
	items := self collection copy.
	items addAll: self pendingAdds.
	self pendingDeletes do: [ :each |
		items remove: each ifAbsent: [] ].
	^ items
		
]
