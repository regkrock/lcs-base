Class {
	#name : 'LxxCountries',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-PrototypeSystem-Core',
	#package : 'Lcs-PrototypeSystem',
	#tag : 'Core'
}

{ #category : 'table definitions' }
LxxCountries >> removeTableDefinition: aTableDefinition [
	self tableDefinitions remove: aTableDefinition
]
