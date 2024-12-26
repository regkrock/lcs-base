Class {
	#name : #LcsBooleanSlotTest,
	#superclass : #LcsPrototypeSystemTest,
	#category : #'Lcs-SlotDefinitionsTests'
}

{ #category : #setUp }
LcsBooleanSlotTest >> domainModelTestClasses [
	^ super domainModelTestClasses
		add: LxxExampleDomain;
		yourself
]

{ #category : #tests }
LcsBooleanSlotTest >> testInitializeSlot [
	| object |
	object := LxxExampleDomain new.
	self assert: object boolean equals: true.
	self assert: (self currentSystem unitOfWork halt).
	self assert: (object instVarNamed: 'boolean') = true description: 'The primitive value has been set because the object is being added. If it was been changed it would be the prvious value'
]
