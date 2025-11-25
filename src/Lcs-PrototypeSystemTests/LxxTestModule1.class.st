Class {
	#name : 'LxxTestModule1',
	#superclass : 'LcsModule',
	#category : 'Lcs-PrototypeSystemTests-Support',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Support'
}

{ #category : 'configuration' }
LxxTestModule1 class >> defaultModuleName [
	^ 'Test 1 Module'
]

{ #category : 'configuration' }
LxxTestModule1 class >> owningModules [
	<owningModule: 'LxxTestSubModule111' priority: 50>
]
