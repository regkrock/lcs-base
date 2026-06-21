Class {
	#name : 'LcsComponentAttributeClassBuilder',
	#superclass : 'LcsBaseClassBuilder',
	#category : 'Lcs-SlotTools-Attributes',
	#package : 'Lcs-SlotTools',
	#tag : 'Attributes'
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
