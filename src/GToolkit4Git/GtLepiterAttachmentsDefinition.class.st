Class {
	#name : 'GtLepiterAttachmentsDefinition',
	#superclass : 'GtLepiterDefinition',
	#category : 'GToolkit4Git-Lepiter',
	#package : 'GToolkit4Git',
	#tag : 'Lepiter'
}

{ #category : 'accessing' }
GtLepiterAttachmentsDefinition >> icon [
	^ self iconNamed: #emptyPackage
]

{ #category : 'accessing' }
GtLepiterAttachmentsDefinition >> iconName [
	"Used in Pharo 12 instead of #icon"
	^ #emptyPackage
]

{ #category : 'accessing' }
GtLepiterAttachmentsDefinition >> initialize [
	super initialize.
	self name: 'attachments'
]
