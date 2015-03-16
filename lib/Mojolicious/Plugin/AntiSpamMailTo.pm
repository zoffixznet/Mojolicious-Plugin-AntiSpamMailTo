package Mojolicious::Plugin::AntiSpamMailTo;

use Mojo::Base 'Mojolicious::Plugin';

# VERSION

use HTML::Entities;

sub register {
    my ($self, $app) = @_;

    $app->helper(
        mailto_href => sub {
            encode_entities 'mailto:' . $_[1], '\w\W';
        },
    );

    $app->helper(
        mailto => sub {
            encode_entities $_[1], '\w\W';
        },
    );
}

'
Q: Whats the object-oriented way to become wealthy?
A: Inheritance
';

__END__

=encoding utf8

=for stopwords noobish bots

=head1 NAME

Mojolicious::Plugin::AntiSpamMailTo - Mojolicious plugin for obfuscating email addresses

=head1 SYNOPSIS

    #!/usr/bin/env perl

    use Mojolicious::Lite;

    plugin 'AntiSpamMailTo';

    get '/' => 'index';

    app->start;

    __DATA__

    @@ index.html.ep

    <p><a
        href="<%= mailto_href %>">Send me an email at <%= mailto %></a
    ></p>

The output in the browser would be this, with each character in the
email address HTML encoded:

    <p><a
        href="&#109;&#97;&#105;&#108;&#116;&#111;&#58;&#122;&#111;&#102;&#102;&#105;&#120;&#64;&#99;&#112;&#97;&#110;&#46;&#99;&#111;&#109;">
            Send me an email at &#122;&#111;&#102;&#102;&#105;&#120;&#64;&#99;&#112;&#97;&#110;&#46;&#99;&#111;&#109;
    </a></p>

=head1 DESCRIPTION

L<Mojolicious::Plugin::AntiSpamMailTo> is a L<Mojolicious> plugin for
outputting email addresses as encoded HTML entities, which
(kinda seems to) confuses a bunch of noobish spam bots, lowering the
amount of crap you get sent to the address.

=head1 METHODS

L<Mojolicious::Plugin::AntiSpamMailTo> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 register

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=head1 HELPERS

=head2 C<mailto>

    Send me an email at <%== mailto 'zoffix@cpan.com' %>

Takes one argument, an email address, and returns an encoded
version of it.

=head2 C<mailto_href>

    <a href="<%== mailto 'zoffix@cpan.com' %>">Send me an email</a>

This is what's you use in C<< href="" >> attributes. Takes one
argument, an email address, prepends string C<< mailto: >> to it,
and returns an encoded version of it.

=head1 REPOSITORY

Fork this module on GitHub:
L<https://github.com/zoffixznet/Mojolicious-Plugin-AntiSpamMailTo>

=head1 BUGS

To report bugs or request features, please use
L<https://github.com/zoffixznet/Mojolicious-Plugin-AntiSpamMailTo/issues>

If you can't access GitHub, you can email your request
to C<bug-mojolicious-plugin-antispammailto at rt.cpan.org>

=head1 AUTHOR

Zoffix Znet C<zoffix at cpan.org>, (L<http://zoffix.com/>)

=head1 LICENSE

You can use and distribute this module under the same terms as Perl itself.
See the C<LICENSE> file included in this distribution for complete
details.

=cut