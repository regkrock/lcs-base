Class {
	#name : 'LcsModuleNameMethodBuilder',
	#superclass : 'LcsMethodBuilder',
	#instVars : [
		'moduleName'
	],
	#category : 'Lcs-SlotTools',
	#package : 'Lcs-SlotTools'
}

{ #category : 'initialize' }
LcsModuleNameMethodBuilder >> initialize [
	super initialize.
	self selector: #defaultModuleName
]

{ #category : 'command' }
LcsModuleNameMethodBuilder >> methodSource [
	^'<1s>
	^ ''<2s>''' expandMacrosWith: self selector with: self moduleName
]

{ #category : 'accessing' }
LcsModuleNameMethodBuilder >> moduleName [
	^ moduleName
]

{ #category : 'accessing' }
LcsModuleNameMethodBuilder >> moduleName: aString [
	moduleName := aString
]
