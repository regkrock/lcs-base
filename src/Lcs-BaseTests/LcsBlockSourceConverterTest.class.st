Class {
	#name : #LcsBlockSourceConverterTest,
	#superclass : #LcsTestCase,
	#category : #'Lcs-BaseTests'
}

{ #category : #tests }
LcsBlockSourceConverterTest >> testCreatingBlockWithInnerSource [
	| existingBlock createdBlock |
	existingBlock := [  ].
	createdBlock := LcsBlockSourceConverter blockWithInnerSourceCode: '' replacing: existingBlock.
	self assert: existingBlock == createdBlock description: 'When contents are the same, original block is returned'.

	existingBlock := [ 1 ].
	createdBlock := LcsBlockSourceConverter blockWithInnerSourceCode: '1' replacing: existingBlock.
	self assert: existingBlock == createdBlock description: 'When contents are the same, original block is returned'.

	existingBlock := [1].
	createdBlock := LcsBlockSourceConverter blockWithInnerSourceCode: '  1  ' replacing: existingBlock.
	self assert: existingBlock == createdBlock description: 'When contents are the same, original block is returned'.

	existingBlock := [1].
	createdBlock := LcsBlockSourceConverter blockWithInnerSourceCode: '  1 + 3  ' replacing: existingBlock.
	self deny: existingBlock == createdBlock.
	self assert: createdBlock asString = '[ 1 + 3 ]'
]

{ #category : #tests }
LcsBlockSourceConverterTest >> testCreatingSlotBlockWithInnerSource [
	| existingBlock createdBlock |

	existingBlock := [1].
	createdBlock := LcsBlockSourceConverter blockWithInnerSourceCode: '  1 + 3  ' replacing: existingBlock parameters: LcsAccessorSlot domainObjectSlotParameters.
	self deny: existingBlock == createdBlock.
	self assert: createdBlock asString = '[ :domainObject :slot | 1 + 3 ]'
]

{ #category : #tests }
LcsBlockSourceConverterTest >> testCreatingSlotBlockWithInnerSourceWithNoArguments [
	| existingBlock createdBlock |

	existingBlock := [1].
	createdBlock := LcsBlockSourceConverter blockWithInnerSourceCode: '  1 + 3  ' replacing: existingBlock.
	self deny: existingBlock == createdBlock.
	self assert: createdBlock asString = '[ 1 + 3 ]'
]

{ #category : #tests }
LcsBlockSourceConverterTest >> testCreation [
	self subject: LcsBlockSourceConverter new.
	self assert:self subject arguments isEmpty
]

{ #category : #tests }
LcsBlockSourceConverterTest >> testReturningInnerSourceCodeFromABlock [
	| innderSourceCode |
	
	innderSourceCode := LcsBlockSourceConverter innerSourceCodeOf: [].
	self assert: innderSourceCode equals: ''.

	innderSourceCode := LcsBlockSourceConverter innerSourceCodeOf: [ 1 ].
	self assert: innderSourceCode equals: '1'.
	
	innderSourceCode := LcsBlockSourceConverter innerSourceCodeOf: [ 1 ].
	self assert: innderSourceCode equals: '1'.
	
	innderSourceCode := LcsBlockSourceConverter innerSourceCodeOf: [ 1].
	self assert: innderSourceCode equals: '1'.

	innderSourceCode := LcsBlockSourceConverter innerSourceCodeOf: [1 ].
	self assert: innderSourceCode equals: '1'.

	innderSourceCode := LcsBlockSourceConverter innerSourceCodeOf: [1].
	self assert: innderSourceCode equals: '1'.

	innderSourceCode := LcsBlockSourceConverter innerSourceCodeOf: [ :a :b | a + b ].
	self assert: innderSourceCode equals: 'a + b'.
]

{ #category : #tests }
LcsBlockSourceConverterTest >> testReturningInnerSourceCodeFromASlotBlock [
	| innderSourceCode |
	
	innderSourceCode := LcsBlockSourceConverter innerSourceCodeOf: [ :domainObject :slot | slot slotName ].
	self assert: innderSourceCode equals: 'slot slotName'.
]
