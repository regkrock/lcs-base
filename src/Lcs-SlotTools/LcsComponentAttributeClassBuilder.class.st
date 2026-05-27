Class {
	#name : 'LcsComponentAttributeClassBuilder',
	#superclass : 'LcsBaseClassBuilder',
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'accessing' }
LcsComponentAttributeClassBuilder class >> defaultTargetSuperclassName [
	^ #LuiComponentAttribute
]

{ #category : 'initialize' }
LcsComponentAttributeClassBuilder >> initialize [
	super initialize.
	self targetSuperclassName: self class defaultTargetSuperclassName
]
