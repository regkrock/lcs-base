Class {
	#name : 'LcsScaledDecimalSlotExamples',
	#superclass : 'LcsExamples',
	#category : 'Lcs-SlotDefinitionsTests-Examples',
	#package : 'Lcs-SlotDefinitionsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsScaledDecimalSlotExamples >> balanceScaledDecimalSlot [
	<gtExample>
	| scaledDecimalSlot |
	scaledDecimalSlot := self newSlot slotName: 'balance'.
	self assert: scaledDecimalSlot slotName equals: 'balance'.
	^ scaledDecimalSlot
]

{ #category : 'tests' }
LcsScaledDecimalSlotExamples >> balanceScaledDecimalSlotWithInitialValueOf100 [
	<gtExample>
	| slot |
	slot := self balanceScaledDecimalSlot.
	slot initialValue: 100s2.
	self
		assert: slot initialValueBlock printString
		equals: '[ :parentDomainObject :slot | 100.00s2 ]'.
	self assert: slot initialValue equals: 100.00s2.
	self assert: slot initialValue printString equals: '100.00s2'.
	^ slot
]

{ #category : 'examples' }
LcsScaledDecimalSlotExamples >> newSlot [
	<gtExample>
	| scaledDecimalSlot |
	scaledDecimalSlot := LcsScaledDecimalSlot new.
	self assert: scaledDecimalSlot class == LcsScaledDecimalSlot.
	self assert: scaledDecimalSlot slotTypes size = 1.
	self assert: (scaledDecimalSlot slotTypes includes: ScaledDecimal).
	self assert: scaledDecimalSlot initialValue equals: 0.
	self assert: scaledDecimalSlot initialValue printString equals: '0.00s2'.
	self assert: scaledDecimalSlot numberOfDecimals equals: 2.
	^ scaledDecimalSlot
]

{ #category : 'tests' }
LcsScaledDecimalSlotExamples >> slotWithModifiedInitialValueBlock [
	<gtExample>
	| slot magritteDescription |
	slot := self newSlot.
	magritteDescription := slot initialValueBlockDescription.
	self assert: magritteDescription notNil.
	self assert: (magritteDescription read: slot) asString equals: '0 asScaledDecimal: slot numberOfDecimals'.
	magritteDescription write: '1 asScaledDecimal: slot numberOfDecimals' to: slot.
	self assert: slot initialValueBlock asString equals: '[ :parentDomainObject :slot | 1 asScaledDecimal: slot numberOfDecimals ]'.
	self assert: slot initialValueBlock isBlock.
	^ slot
]
