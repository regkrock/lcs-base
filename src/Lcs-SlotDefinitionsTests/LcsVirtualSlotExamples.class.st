Class {
	#name : 'LcsVirtualSlotExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsVirtualSlotExamples >> isInEffectVirtualSlot [
	<gtExample>
	| slot |
	slot := self newSlot.
	slot slotName: 'isInEffect'.
	self assert: slot slotName = 'isInEffect'.	
	slot computedValueAccessor: '_isInEffect'.
	self assert: slot computedValueAccessor equals: #'_isInEffect'.
	slot computedValueAccessor: #dummy.
	self should: [ slot currentSlotVarIn: LcsDateRange new] raise: Error description: 'The #dummy slot does not exist in LcsDateRange'.
	^ slot
]

{ #category : 'examples' }
LcsVirtualSlotExamples >> newSlot [
	<gtExample>
	| slot |
	slot := LcsVirtualSlot new.
	self assert: slot slotName isNil.
	self assert: slot slotTypes isEmpty.
	self assert: slot slotTypes class = OrderedCollection.
	self assert: slot computedValueAccessor isEmpty.
	self assert: slot isVirtualSlot.
	self
		assert: slot defaultComputedValueBlock printString
		equals: '[ :parentDomainObject :slot | parentDomainObject perform: slot computedValueAccessor ]'.
	self
		assert: slot computedValueBlock printString
		equals: '[ :parentDomainObject :slot | parentDomainObject perform: slot computedValueAccessor ]'.
	self
		should: [ slot slotVarPut: 'anObject' in: LcsDateRange new ]
		raise: Error
		description: 'Updating not allowed'.
	self
		should: [ slot slotVarNamed: 'anObject' in: LcsDateRange new ]
		raise: LcsSlotUpdateNotAllowedError.
	^ slot
]

{ #category : 'examples - errors' }
LcsVirtualSlotExamples >> slotUpdateNotAllowedError [
	<gtExample>
	<noTest>
	| slot |
	slot := self newSlot.
	^ slot slotVarNamed: 'foo' in: String new
]
