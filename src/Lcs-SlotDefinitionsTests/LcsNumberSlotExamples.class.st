Class {
	#name : 'LcsNumberSlotExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsNumberSlotExamples >> initialWeightOfPerson [
	<gtExample>
	| person |
	person := self personWithWeightSlot.
	self assert: person weight isZero.
	^ person
]

{ #category : 'tests' }
LcsNumberSlotExamples >> personWithWeightChangedTo100_5 [
	| person |
	person := LxxPerson new.
	self assert: person weight isZero.
	person weight: 100.5.
	self assert: person isInAddingState.
	self assert: person weight equals: 100.5.
	self assert: ((person slotDefinitionNamed: 'weight') persistedSlotVarIn: person) equals: 100.5.
	self currentSystem applyChanges.
	self assert: ((person slotDefinitionNamed: 'weight') persistedSlotVarIn: person) equals: 100.5.
	^ person
]

{ #category : 'tests' }
LcsNumberSlotExamples >> personWithWeightSetTo100_5 [
	| person |
	person := LxxPerson new.
	self assert: person weight isZero.
	person weight: 100.5.
	self assert: person isInAddingState.
	self assert: person weight equals: 100.5.
	self assert: ((person slotDefinitionNamed: 'weight') persistedSlotVarIn: person) equals: 100.5.
	self currentSystem applyChanges.
	self assert: ((person slotDefinitionNamed: 'weight') persistedSlotVarIn: person) equals: 100.5.
	^ person
]

{ #category : 'examples' }
LcsNumberSlotExamples >> personWithWeightSlot [
	<gtExample>
	| slot person |
	slot := self weightNumberSlot.
	slot initialValue: 0.
	person := LxxPerson new.
	self assert: person weight isZero.
	self assert: person isInAddingState.
	^ person
]

{ #category : 'examples' }
LcsNumberSlotExamples >> weightNumberSlot [
	<gtExample>
	| slot |
	self ensureCurrentSystemIsPrototypeSystem.
	slot := (LxxPerson slotModel slotDefinitionNamed: 'weight').
	self assert: (slot isKindOf: LcsNumberSlot).
	^ slot
]

{ #category : 'examples' }
LcsNumberSlotExamples >> weightNumberSlotInitialValue [
	<gtExample>
	| slot |
	slot := self weightNumberSlot.
	self assert: slot initialValueBlock printString equals: '[ :parentDomainObject :slot | 0 ]'.
	self assert: slot initialValue equals: 0.
	^ slot initialValue
]

{ #category : 'examples' }
LcsNumberSlotExamples >> weightNumberSlotInitialValueChangedTo100 [
	<gtExample>
	| slot |
	slot := self weightNumberSlot.
	slot initialValue: 100.
	self assert: slot initialValueBlock printString equals: '[ :parentDomainObject :slot | 100 ]'.
	self assert: slot initialValue equals: 100.
	^ slot initialValue
]
