Class {
	#name : 'LcsDomainObjectSlot',
	#superclass : 'LcsAccessorSlot',
	#traits : 'LtAggregateAssociation',
	#classTraits : 'LtAggregateAssociation classTrait',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'gt views' }
LcsDomainObjectSlot >> addAssociationsToUmlModel: aUmlModel [
	super addAssociationsToUmlModel: aUmlModel.
	aUmlModel
		addAssociation: self slotName
			from: self domainClass
			to: self slotTypes first
]

{ #category : 'gt views' }
LcsDomainObjectSlot >> addClassesToUmlModel: umlModel [ 
	super addClassesToUmlModel: umlModel.
	self slotTypes notEmpty
		ifTrue: [ umlModel addClassNamed: self slotTypes first ]
]
