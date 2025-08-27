Class {
	#name : #LxxPersonExamples,
	#superclass : #LcsObjectExamples,
	#category : #'Lcs-PrototypeSystemTests-Tests'
}

{ #category : #tests }
LxxPersonExamples >> slotDefintionViewItems [
	<gtExample>
	| allSlotDefinitionViewItems|
	self ensureCurrentsystemIsPrototypeSystem.
	allSlotDefinitionViewItems := LxxPerson slotDefinitionViewItems.
	self assert: allSlotDefinitionViewItems notEmpty.
	^ allSlotDefinitionViewItems
]
