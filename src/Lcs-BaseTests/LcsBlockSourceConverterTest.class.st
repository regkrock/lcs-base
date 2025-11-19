Class {
	#name : 'LcsBlockSourceConverterTest',
	#superclass : 'LcsTestCase',
	#category : 'Lcs-BaseTests-Tests',
	#package : 'Lcs-BaseTests',
	#tag : 'Tests'
}

{ #category : 'tests' }
LcsBlockSourceConverterTest >> testCreatingBlockWithInnerSource [
	| existingBlock createdBlock |
	existingBlock := [  ].
	createdBlock := LcsBlockSourceConverter blockWithInnerSourceCode: '' toReplace: existingBlock.
	self assert: existingBlock == createdBlock description: 'When contents are the same, original block is returned'.

	existingBlock := [ 1 ].
	createdBlock := LcsBlockSourceConverter blockWithInnerSourceCode: '1' toReplace: existingBlock.
	self assert: existingBlock == createdBlock description: 'When contents are the same, original block is returned'.

	existingBlock := [1].
	createdBlock := LcsBlockSourceConverter blockWithInnerSourceCode: '  1  ' toReplace: existingBlock.
	self assert: existingBlock == createdBlock description: 'When contents are the same, original block is returned'.

	existingBlock := [1].
	createdBlock := LcsBlockSourceConverter blockWithInnerSourceCode: '  1 + 3  ' toReplace: existingBlock.
	self deny: existingBlock == createdBlock.
	self assert: createdBlock asString = '[ 1 + 3 ]'
]

{ #category : 'tests' }
LcsBlockSourceConverterTest >> testCreatingSlotBlockWithInnerSource [
	| existingBlock createdBlock |

	existingBlock := [1].
	createdBlock := LcsBlockSourceConverter 
						blockWithArguments: LcsAccessorSlot domainObjectSlotBlockArguments 
						innerSourceCode: '  1 + 3  ' 
						toReplace: existingBlock .
	self deny: existingBlock == createdBlock.
	self assert: createdBlock asString = '[ :domainObject :slot | 1 + 3 ]'
]

{ #category : 'tests' }
LcsBlockSourceConverterTest >> testCreatingSlotBlockWithInnerSourceWithNoArguments [
	| existingBlock createdBlock |

	existingBlock := [1].
	createdBlock := LcsBlockSourceConverter blockWithInnerSourceCode: '  1 + 3  ' toReplace: existingBlock.
	self deny: existingBlock == createdBlock.
	self assert: createdBlock asString = '[ 1 + 3 ]'
]

{ #category : 'tests' }
LcsBlockSourceConverterTest >> testCreation [
	self subject: LcsBlockSourceConverter new.
	self assert:self subject arguments isEmpty
]

{ #category : 'tests' }
LcsBlockSourceConverterTest >> testReplacingExistingBlockSourceWithNewBlock [
	| existingBlock createdBlock |
	existingBlock := [ 1 ].
	createdBlock := LcsBlockSourceConverter
			blockWithArguments: LcsAccessorSlot domainObjectSlotBlockArguments
			innerSourceCode: '  1 + 3  '
			toReplace: existingBlock.
	self deny: existingBlock == createdBlock.
	self assert: createdBlock asString = '[ :domainObject :slot | 1 + 3 ]'
]

{ #category : 'tests' }
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

{ #category : 'tests' }
LcsBlockSourceConverterTest >> testReturningInnerSourceCodeFromASlotBlock [
	| innderSourceCode |
	
	innderSourceCode := LcsBlockSourceConverter innerSourceCodeOf: [ :domainObject :slot | slot slotName ] arguments: #(domainObject slot).
	self assert: innderSourceCode equals: 'slot slotName'.
]
