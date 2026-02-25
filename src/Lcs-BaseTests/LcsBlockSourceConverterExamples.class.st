Class {
	#name : 'LcsBlockSourceConverterExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-BaseTests-Examples',
	#package : 'Lcs-BaseTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsBlockSourceConverterExamples >> blockSourceConverter [
	<gtExample>
	self subject: LcsBlockSourceConverter new.
	self assert:self subject arguments isEmpty.
	^ self subject
]

{ #category : 'examples' }
LcsBlockSourceConverterExamples >> blockWitExistingBlockSourceReplaedWithNewBlock [
	<gtExample>
	| existingBlock createdBlock |
	existingBlock := [ 1 ].
	createdBlock := LcsBlockSourceConverter
			blockWithArguments: LcsAccessorSlot domainObjectSlotBlockArguments
			innerSourceCode: '  1 + 3  '
			toReplace: existingBlock.
	self assert: existingBlock ~~ createdBlock.
	self assert: createdBlock asString = '[ :parentDomainObject :slot | 1 + 3 ]'.
	^ createdBlock
]

{ #category : 'examples' }
LcsBlockSourceConverterExamples >> blockWithInnerSource [
	<gtExample>
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
	self assert: (existingBlock == createdBlock) not.
	self assert: createdBlock asString = '[ 1 + 3 ]'.
	^ createdBlock
]

{ #category : 'examples' }
LcsBlockSourceConverterExamples >> innerSourceCodeFromABlock [
	<gtExample>
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
	^ innderSourceCode
]

{ #category : 'examples' }
LcsBlockSourceConverterExamples >> innerSourceCodeFromASlotBlock [
	<gtExample>
	| innderSourceCode |
	
	innderSourceCode := LcsBlockSourceConverter innerSourceCodeOf: [ :parentDomainObject :slot | slot slotName ] arguments: #(domainObject slot).
	self assert: innderSourceCode equals: 'slot slotName'.
	^ innderSourceCode
]

{ #category : 'examples' }
LcsBlockSourceConverterExamples >> slotBlockWithInnerSource [
	<gtExample>
	| existingBlock createdBlock |
	existingBlock := [1].
	createdBlock := LcsBlockSourceConverter 
						blockWithArguments: LcsAccessorSlot domainObjectSlotBlockArguments 
						innerSourceCode: '  1 + 3  ' 
						toReplace: existingBlock .
	self assert: existingBlock ~~ createdBlock.
	self assert: createdBlock asString = '[ :parentDomainObject :slot | 1 + 3 ]'.
	^ createdBlock
]

{ #category : 'examples' }
LcsBlockSourceConverterExamples >> slotBlockWithInnerSourceWithNoArguments [
	<gtExample>
	| existingBlock createdBlock |
	existingBlock := [1].
	createdBlock := LcsBlockSourceConverter blockWithInnerSourceCode: '  1 + 3  ' toReplace: existingBlock.
	self assert: existingBlock ~~ createdBlock.
	self assert: createdBlock asString = '[ 1 + 3 ]'.
	^ createdBlock
]
