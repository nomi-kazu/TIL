<template>
  <v-card-text class="px-0">
    <ValidationProvider
      :name="$attrs.label"
      :rules="rules"
      :vid="$attrs.vid"
    >
      <div class="markdown-editor">
        <client-only>
          <mavon-editor
            v-model="inputValue"
            background-color="grey darken-1"
            color="yellow darken-3"
            style="z-index: 1"
            :toolbars="markdownOption"
            language="ja"
            disabled
            v-bind="$attrs"
            v-on="$listeners"
          />
        </client-only>
      </div>
    </ValidationProvider>
  </v-card-text>
</template>

<script>
export default {
  props: {
    rules: {
      type: [Object, String],
      default: ''
    },

    value: {
      type: String,
      default: ''
    }
  },

  data () {
    return {
      markdownOption: {
        bold: true,
        italic: true,
        header: true,
        underline: true,
        strikethrough: true,
        mark: true,
        superscript: true,
        subscript: true,
        quote: true,
        ol: true,
        ul: true,
        link: true,
        imagelink: false,
        code: true,
        table: true,
        fullscreen: true,
        readmodel: true,
        htmlcode: true,
        help: true,
        undo: true,
        redo: true,
        trash: true,
        save: true,
        navigation: true,
        alignleft: true,
        aligncenter: true,
        alignright: true,
        subfield: true,
        preview: true
      }
    }
  },

  computed: {
    inputValue: {
      get () {
        return this.value
      },

      set (value) {
        this.$emit('input', value)
      }
    }
  }
}
</script>
